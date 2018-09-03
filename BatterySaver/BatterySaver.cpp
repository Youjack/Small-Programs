#include <iostream>
#include <Windows.h>
using namespace std;

int main()
{
	SYSTEM_POWER_STATUS Status;
	GetSystemPowerStatus(&Status);
	cout << (int)Status.BatteryLifePercent << "%, ";
	HWND hwnd = FindWindow("ConsoleWindowClass", NULL);
	if ((int)Status.ACLineStatus == 1)
	{
		cout << "Charging !" << endl;
		cout << "Hide Window in 10sec" << endl;
		Sleep(10000);
		ShowWindow(hwnd, SW_HIDE);
		while ((int)Status.ACLineStatus == 1)
		{
			GetSystemPowerStatus(&Status);
			if ((int)Status.BatteryLifePercent >= 79)
			{
				ShowWindow(hwnd, SW_SHOW);
				cout << "               STOP CHARGING !!!" << endl;
				cout << "It is time to  STOP CHARGING !!!" << endl;
				cout << "               STOP CHARGING !!!" << endl;
				system("pause");
				return 1;
			}
			else Sleep(60000);
		}
	}
	ShowWindow(hwnd, SW_SHOW);
	cout << "Not Charging !" << endl;
	system("pause");
}