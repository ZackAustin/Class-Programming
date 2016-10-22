#include <cassert>
#include <iostream>
#include <map>
#include <stdexcept>
#include <string>
using namespace std;

class Product {
public:
    virtual string getSKU() const = 0;
    virtual string getName() const = 0;
    virtual string getDescription() const = 0;
    virtual double getPrice() const = 0;
    virtual void setName(const string& n) = 0;
    virtual void setDescription(const string& d) = 0;
    virtual void setPrice(const double& p) = 0;
};

class MyProduct : public Product {
    string sku;
    string name;
    string description;
    double price;
public:
    MyProduct(const string& s, const string& n,
            const string& d, const double& p)
    : sku(s), name(n), description(d) {
        price = p;
    }
    string getSKU() const {
        return sku;
    }
    string getName() const {
        return name;
    }
    string getDescription() const {
        return description;
    }
    double getPrice() const {
        return price;
    }
    void setName(const string& n) {
        name = n;
    }
    void setDescription(const string& d) {
        description = d;
    }
    void setPrice(const double& p) {
        price = p;
    }
};

class ProductDB {
    // The Database Record
    struct ProductData {
        ProductData() {
            price = 0;
        }
        ProductData(const string& n, const string& d, const double& p)
        : name(n), description(d) {
            price = p;
        }
        string name;
        string description;
        double price;
    };
    map<string, ProductData> data;
public:
    MyProduct* retrieve(const string& sku) {
        map<string,ProductData>::const_iterator where = data.find(sku);
        if (where == data.end())
            throw runtime_error("no such record");
        ProductData pr(where->second);
        return new MyProduct(sku, pr.name, pr.description, pr.price);
    }
    void store(const string& s, const string& n,
               const string& d, const double& p) {
        data[s] = ProductData(n, d, p);
    }
};

class MyProductProxy : public Product {
    MyProduct* theProduct;
    string key; // sku
    static ProductDB* theDB;
public:
    MyProductProxy(const string& s) : key (s) {
        assert(theDB);
        theProduct = theDB->retrieve(key);
    }
    ~MyProductProxy() {
        theDB->store(theProduct->getSKU(), theProduct->getName(),
                     theProduct->getDescription(), theProduct->getPrice());
        delete theProduct;
    }
    static void setDB(ProductDB* db) {
        theDB = db;
    }
    string getSKU() const {
        return theProduct->getSKU();
    }
    string getName() const {
        return theProduct->getName();
    }
    string getDescription() const {
        return theProduct->getDescription();
    }
    double getPrice() const {
        return theProduct->getPrice();
    }
    void setName(const string& n) {
        theProduct->setName(n);
    }
    void setDescription(const string& d) {
        theProduct->setDescription(d);
    }
    void setPrice(const double& p) {
        theProduct->setPrice(p);
    }
};
ProductDB* MyProductProxy::theDB;

void inspect(const Product& p) {
    // This is the transparent context
    cout << "SKU = " << p.getSKU() << endl;
    cout << "Name = " << p.getName() << endl;
    cout << "Description = " << p.getDescription() << endl;
    cout << "Price = " << p.getPrice() << endl << endl;
}
int main() {
    ProductDB theDB;
    theDB.store("1234", "Gizmo", "A Fun Toy", 12.34);
    theDB.store("5678", "Flop", "A Flexible Mop", 56.78);
    MyProductProxy::setDB(&theDB);
    {
        MyProductProxy p1("1234");
        inspect(p1);
        p1.setPrice(100);
    }
    MyProductProxy p1("1234");
    inspect(p1);
}
