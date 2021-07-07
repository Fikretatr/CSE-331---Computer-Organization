#include <iostream>
using namespace std;

int ChecknumPossibility(int num,int arr[],int arraySize){
    if (num == 0)
        return 1;
 
    if (arraySize==0 || num<0)
        return 0;

    return ChecknumPossibility(num - arr[arraySize],arr ,arraySize - 1 ) || ChecknumPossibility(num, arr, arraySize - 1);
}

int main()
{
 int arraySize;
 int arr[100];
 int num;
 int returnVal;
 cin >> arraySize;
 cin >> num;
 for(int i = 0; i < arraySize; ++i)
 {
 cin >> arr[i];
 }

 returnVal = ChecknumPossibility(num, arr, arraySize);

 if(returnVal == 1)
 {
 cout << "Possible!" << endl;
 }
 else
 {
 cout << "Not possible!" << endl;
 }

 return 0;
}