import serial
import pyautogui
import time

PORT = '/dev/cu.usbmodem14101'
BAUD_RATE = 9600

try:
    ser = serial.Serial(PORT, BAUD_RATE, timeout=1)
    time.sleep(2)
    print("아두이노 연결 성공! 신호를 기다리는 중...")

    while True:
        if ser.in_waiting > 0:
            incoming = ser.read().decode('utf-8')
            
            if incoming == 'A':
                print("신호 A 수신: 첫 번째 문장 자동완성 중...")
                pyautogui.write("Hello, this is autocomplete for A!") 
                
            elif incoming == 'B':
                print("신호 B 수신: 두 번째 문장 자동완성 중...")
                pyautogui.write("Welcome to Bae Euijin's Arduino Project!")

        time.sleep(0.01)

except KeyboardInterrupt:
    print("\n프로그램을 종료합니다.")
except Exception as e:
    print(f"에러 발생: {e}")
finally:
    if 'ser' in locals() and ser.is_open:
        ser.close()