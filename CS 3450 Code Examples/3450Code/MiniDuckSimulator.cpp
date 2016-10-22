#include "Duck.h"

int main() {
   Duck* pond[2];
   pond[0] = new MallardDuck;
   pond[1] = new RubberDuck;
   for (int i = 0; i < 2; ++i) {
      pond[i]->performFly();
      pond[i]->performQuack();
   }
}
