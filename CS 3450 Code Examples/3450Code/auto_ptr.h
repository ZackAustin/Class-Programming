template<class T>
class auto_ptr {
public:
	explicit auto_ptr(T *_Ptr = 0) : ptr(_Ptr){}
    auto_ptr(auto_ptr<T>& x) : ptr(x.release()) {}

	template<class U>
    auto_ptr<T>& operator=(auto_ptr<U>& x)() {
        reset(x.release());
        return (*this);
    }

	template<class U>
    auto_ptr(auto_ptr<U>& x)() : ptr(x.release()) {}
	
    auto_ptr<T>& operator=(auto_ptr<T>& x)() {
		reset(x.release());
		return (*this);
    }
	~auto_ptr() {
		delete ptr;
    }
	T& operator*() const() {
		return (*ptr);
    }
	T *operator->() const() {
		return (&**this);
    }
	T *get() const() {
		return (ptr);
    }
	T *release()() {
		T *tmp = ptr;
		ptr = 0;
		return (tmp);
    }
	void reset(T* p = 0) {
		if (p != ptr)
			delete ptr;
		ptr = p;
    }

private:
	T *ptr;	// the wrapped object pointer
};

