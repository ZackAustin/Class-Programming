#include "smartptr.h"

template <class Counted> SmartPtr<Counted>&
SmartPtr<Counted>::operator = (Counted* rhs)
{
	// simply return this if lhs refers to the same object as this
	if ( _counted_obj_ptr == rhs )
	{
		return *this;
	}

	// let go of current object
	cleanup ();

	// get reference to new object
	copy (rhs);

	return *this;
}

template <class Counted> void
SmartPtr<Counted>::copy (Counted* master)
{
	_counted_obj_ptr = master;

	if ( _counted_obj_ptr != 0)
	{
		_counted_obj_ptr->_refcnt++;
	}
}

template <class Counted> void
SmartPtr<Counted>::cleanup ()
{
	if ( _counted_obj_ptr != 0 )
	{
		_counted_obj_ptr->_refcnt--;
		if ( _counted_obj_ptr->_refcnt == 0 )
		{
			delete _counted_obj_ptr;
			_counted_obj_ptr = 0;
		}
	}
}
