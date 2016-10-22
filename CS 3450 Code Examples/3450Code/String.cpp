// Illustrating DRY with a simple string class
#include <cstring>
using std::strcpy;

class String {
public:
   String(const char* s = "") {
      data = clone(s);
   }
   String(const String& s) {
      data = clone(s.data);
   }
   String& operator=(const String& s) {
      char* newData = clone(s.data);
      delete [] data;
      data = newData;
   }
   ~String();
   void append(const String&);
   String substr(int start, int count);
private:
   char* clone(const char* s) {
      char* newData = new char[strlen(s)+1];
      return strcpy(newData, s);
   }
   char* data;
};
