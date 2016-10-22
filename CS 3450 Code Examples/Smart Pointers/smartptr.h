#ifndef _smartptr_h
#define _smartptr_h

#include <stddef.h>

// 
// This file contains both SmartPtr<T> and RefCnt<T>, which are used to
// provide reference-counted pointers and automatic deletion of objects as the
// last reference goes away.
//
// This variation of SmartPtr is inappropriate for referring to objects
// related by a common base class and there is a need to reference the
// object by both their derived class and base class. For such situations,
// use SmartPtrB<T> and RefCntB.
//
// WARNING: If using smart pointers, ensure that *all* references to the object
// is via smart pointers. Otherwise, when the last smart pointer goes
// away, the object will be deleted while non-smart (dumb?) pointers
// are now dangling.


// As the type of the reference count, RefType defines the limit
// on the number of references to a single Counted object
typedef unsigned int	RefType;

template <class Counted>
class SmartPtr
{
public:
	SmartPtr (Counted* cntd): _counted_obj_ptr (cntd)
			{ cntd != 0 ? cntd->_refcnt++ : 0; }

	SmartPtr (): _counted_obj_ptr (0) {}

	SmartPtr (const SmartPtr& master) { copy (master._counted_obj_ptr); }

	~SmartPtr () { cleanup (); }

	// necessary to 1) use smart pointers in RWTValOrderedVectors, and
	// 2) keep the compiler from complaining about having a new but
	// not a delete declared
	void
	operator delete (void* t) { ::operator delete (t); }

	SmartPtr&
	operator = (const SmartPtr& rhs)
		{ return operator = (rhs._counted_obj_ptr); }
	
	SmartPtr&
	operator = (Counted* rhs);

	bool
	is_null () const { return _counted_obj_ptr == 0; }

	RefType
	refCnt () const
	{ return _counted_obj_ptr == 0 ? 0 : _counted_obj_ptr->_refcnt; }

	Counted*
	operator -> () { return _counted_obj_ptr; }

	const Counted*
	operator -> () const { return _counted_obj_ptr; }

	// for completeness...
	Counted&
	operator * () { return *_counted_obj_ptr; }

	const Counted&
	operator * () const { return *_counted_obj_ptr; }

	// provide equality operators that will provide the same
	// semantics as the built-in one for pointers
	friend bool operator == (const SmartPtr<Counted>& left,
				const SmartPtr<Counted>& right)
		{ return left._counted_obj_ptr == right._counted_obj_ptr; }
	friend bool operator == (const SmartPtr<Counted>& left,
				const Counted* right)
	{ return left._counted_obj_ptr == right; }
	friend bool operator == (const Counted* left,
				const SmartPtr<Counted>& right)
	{ return left == right._counted_obj_ptr; }


	// provide inequality operators that will provide the same
	// semantics as the built-in one for pointers
	friend bool operator != (const SmartPtr<Counted>& left,
				const SmartPtr<Counted>& right)
		{ return left._counted_obj_ptr != right._counted_obj_ptr; }
	friend bool operator != (const SmartPtr<Counted>& left,
				const Counted* right)
	{ return left._counted_obj_ptr != right; }
	friend bool operator != (const Counted* left,
				const SmartPtr<Counted>& right)
	{ return left != right._counted_obj_ptr; }

protected:
	// prevent the direct creation of dynamically allocated SmartPtr
	// objects, which would subvert their main purpose
	// - had to provide definitions because purify references them
	//   if declared!
	// - had to make protected so that classes can be derived from this
	//   to provide enhanced typedef
	void*
	operator new (size_t) { return 0;}

	// disallow taking the address of a smart pointer
	SmartPtr*
	operator& ();

private:
	// copy master value to this
	void
	copy (Counted* master);

	// remove reference to OpTreeArray object, deleting it if necessary
	void
	cleanup ();

	Counted* _counted_obj_ptr;
};

// RefCnt base class

template <class Counted>
class RefCnt
{
	friend class SmartPtr<Counted>;
protected:
	RefCnt (): _refcnt (0) {}
private:
	RefType	_refcnt;
};

#endif // _smartptr_h
