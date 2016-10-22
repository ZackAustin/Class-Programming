//Zack Austin - D2PartA, SemiMap - 12/15/13

import std.stdio, std.typecons, std.conv;

struct Semimap(K,V)
{
	private Nullable!(V)[K] stuff; //"semipair" associative array
	//rest of code here
	void set(K a){stuff[a] = null;}
	void set(K a, V b) {stuff[a] = b;}
	Tuple!(int, int) count()
	{
		int pairCount = 0, singletonCount = 0;
		foreach (k,v; stuff)
			if (v == null)
				singletonCount++;
			else
				pairCount++;
		auto TP = tuple(singletonCount, pairCount);
		return TP;
	}

	int pairCount()
	{
		int pairC = 0;
		foreach (k,v; stuff)
			if (v != null)
				pairC++;
		return pairC;
	}

	int singCount()
	{
		int singleC = 0;
		foreach (k,v; stuff)
			if (v == null)
				singleC++;
		return singleC;
	}

	bool hasKey(int aKey)
	{
		bool foundKey = false;
		foreach (k, v; stuff)
			if (k == aKey)
				foundKey = true;
		return foundKey;
	}

	Nullable!string get(int item)
	{
		Nullable!string someItem;
		foreach (k, v; stuff)
			if (k == item)
				someItem = v;
		return someItem;
	}

	auto keys(){return stuff.keys();}

	auto values()
	{
		auto nonNullItems = new V[0];
		foreach (k, v; stuff)
		{
			if (v != null)
			{
				nonNullItems.length += 1;
				nonNullItems[nonNullItems.length - 1] = v;
			}
		}
		return nonNullItems;
	}

	auto byKey(){return stuff.byKey();}

	auto byValue(){return stuff.byValue();}

	void reset(int a){set(a);}

	void remove(int a){stuff.remove(a);}

	string toString()
	{
		string aaToString = "[";	//add opening bracket
		if (stuff.length > 0)
		{
			foreach (k,v; stuff) //add elements
			{
				if (v == null)
					aaToString = aaToString ~ to!string(k) ~ ",";
				else
					aaToString = aaToString ~ to!string(k) ~ ":" ~ v ~ ",";
			}
		}
		else
			aaToString = aaToString ~ ",";
		aaToString = aaToString[0..$-1]; //slice off end comma
		aaToString = aaToString ~ "]"; //add closing bracket
		return aaToString;
	}
}

void main()
{
	Semimap!(int, string) sm;
	writeln(sm);
	sm.set(2);
	sm.set(1, "one");
	sm.set(3);
	writeln(sm.count);
	writeln(sm.pairCount);
	writeln(sm.singCount);
	writeln(sm);
	writeln(sm.hasKey(1));
	writeln(sm.get(1));
	writeln(sm.hasKey(10));
	auto val = sm.get(2);
	assert(val is null);
	writeln(sm.keys);
	writeln(sm.values);
	foreach(k; sm.byKey)
		writeln("key = ",k);
	foreach(v; sm.byValue)
		if (!(v is null))
			writeln("value = ",v);
	sm.set(3,"three");
	writeln(sm);
	sm.reset(3);
	writeln(sm);
	sm.remove(3);
	writeln(sm);
}
