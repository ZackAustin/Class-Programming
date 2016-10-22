#include <iostream>
#include <fstream>
#include <typeinfo>
using namespace std;

class Top
{
public:
   Top(int x)
   {
      // For creating objects directly
      this->x = x;
   }
   virtual void display(ostream& os) const
   {
      // Convenience function:
      // More readable than serialized output
      os << "Type = " << getType() << ','
         << "Value = " << x;
   }
   void store(ostream& os)
   {
      writeData(os);
   }
   static Top* retrieve(istream& is);

protected:
   enum Type {TOP, MIDDLE, BOTTOM};
   Top()
   {
      // Default ctor (used by Top::retrieve)
      x = 0;
   }
   virtual Type getType() const
   {
      return TOP;
   }
   virtual void writeData(ostream& os)
   {
      os << getType() << endl;
      os << x << endl;
   }
   virtual void readData(istream& is)
   {
      is >> x;
   }

private:
   int x;
};

class Middle : public Top
{
   typedef Top Super;
   friend Top* Top::retrieve(istream&);

public:
   Middle(int x, int y) : Top(x)
   {
      this->y = y;
   }
   virtual void display(ostream& os) const
   {
      Super::display(os);
      os << ',' << y;
   }

protected:
   Middle()
   {
      // Default ctor (used by Top::retrieve)
      y = 0;
   }
   virtual Type getType() const
   {
      return MIDDLE;
   }
   virtual void writeData(ostream& os)
   {
      Super::writeData(os);
      os << y << endl;
   }
   virtual void readData(istream& is)
   {
      Super::readData(is);
      is >> y;
   }

private:
      int y;
};

class Bottom : public Middle
{
   typedef Middle Super;
   friend Top* Top::retrieve(istream&);

public:
   Bottom(int x, int y, int z) : Middle(x,y)
   {
      this->z = z;
   }
   virtual void display(ostream& os) const
   {
      Super::display(os);
      os << ',' << z;
   }

protected:
   Bottom()
   {
      z = 0;
   }
   virtual Type getType() const
   {
      return BOTTOM;
   }
   virtual void writeData(ostream& os)
   {
      Super::writeData(os);
      os << z << endl;
   }
   virtual void readData(istream& is)
   {
      Super::readData(is);
      is >> z;
   }

private:
   int z;
};

Top* Top::retrieve(istream& is)
{
   Top* p;
   int t;
   is >> t;

   switch(Type(t))
   {
   case TOP:
      p = new Top;
      break;
   case MIDDLE:
      p = new Middle;
      break;
   case BOTTOM:
      p = new Bottom;
      break;
   }
   p->readData(is);
   return p;
}

int main()
{
   ofstream outf("serialize.dat");
   Top t(1);
   t.store(outf);
   Middle m(1,2);
   m.store(outf);
   Bottom b(1,2,3);
   b.store(outf);
   outf.close();

   ifstream inf("serialize.dat");
   Top* e1 = Top::retrieve(inf);
   e1->display(cout); cout << endl;
   delete e1;

   e1 = Top::retrieve(inf);
   e1->display(cout); cout << endl;
   delete e1;

   e1 = Top::retrieve(inf);
   e1->display(cout); cout << endl;
   delete e1;
}

