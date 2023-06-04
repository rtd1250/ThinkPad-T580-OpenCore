// Patched Notifiers SSDT for dual battery support
// For Lenovo ThinkPad T580

DefinitionBlock ("", "SSDT", 2, "ACDT", "DBAT", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC, DeviceObj)
    External (_SB.PCI0.LPCB.EC.BATC, DeviceObj)
    External (_SB.PCI0.LPCB.EC.CLPM, MethodObj)
    External (_SB.PCI0.LPCB.EC.HB1A, MethodObj)
    External (_SB.PCI0.LPCB.EC.HKEY.MHKQ, MethodObj)
    External (CLPM, MethodObj)
    External (HB0A, MethodObj)
    External (HB1A, MethodObj)
    External (BT2T, FieldUnitObj)
    External (SLUL, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BAT1.SBLI, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.BAT1.XB1S, FieldUnitObj)
    External (\_SB.PCI0.LPCB.EC.BAT0.B0ST, FieldUnitObj)
    External (\_SB.PCI0.LPCB.EC.BAT1.B1ST, FieldUnitObj)
    External (_SB.PCI0.LPCB.EC.XQ22, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ4A, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ4B, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ4C, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ4D, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ24, MethodObj)
    External (_SB.PCI0.LPCB.EC.XQ25, MethodObj)
    External (_SB.PCI0.LPCB.EC.XFCC, MethodObj)
    External (_SB.PCI0.LPCB.EC.XATW, MethodObj)

    Scope (\_SB.PCI0.LPCB.EC)
    {
        Method (_Q22, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                If (HB0A)
                {
                    Notify (BATC, 0x80) // Status Change
                }

                If (HB1A)
                {
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ22 ()
            }
        }

        Method (_Q4A, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x81) // Information Change
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ4A ()
            }
        }

        Method (_Q4B, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x80) // Status Change
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ4B ()
            }
        }

        Method (_Q4C, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                \_SB.PCI0.LPCB.EC.CLPM ()
                If (\_SB.PCI0.LPCB.EC.HB1A)
                {
                    \_SB.PCI0.LPCB.EC.HKEY.MHKQ (0x4010)
                    Notify (\_SB.PCI0.LPCB.EC.BATC, 0x01) // Device Check
                }
                Else
                {
                    \_SB.PCI0.LPCB.EC.HKEY.MHKQ (0x4011)
                    If (\_SB.PCI0.LPCB.EC.BAT1.XB1S)
                    {
                        Notify (\_SB.PCI0.LPCB.EC.BATC, 0x03) // Eject Request
                    }
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ4C ()
            }
        }

        Method (_Q4D, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                If (\BT2T)
                {
                    If ((^BAT1.SBLI == 0x01))
                    {
                        Sleep (0x0A)
                        If ((HB1A && (SLUL == 0x00)))
                        {
                            ^BAT1.XB1S = 0x01
                            Notify (\_SB.PCI0.LPCB.EC.BATC, 0x01) // Device Check
                        }
                    }
                    ElseIf ((SLUL == 0x01))
                    {
                        ^BAT1.XB1S = 0x00
                        Notify (\_SB.PCI0.LPCB.EC.BATC, 0x03) // Eject Request
                    }
                }

                If ((^BAT1.B1ST & ^BAT1.XB1S))
                {
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ4D ()
            }
        }

        Method (_Q24, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                CLPM ()
                Notify (BATC, 0x80) // Status Change
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ24 ()
            }
        }

        Method (_Q25, 0, NotSerialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
            {
                If ((^BAT1.B1ST & ^BAT1.XB1S))
                {
                    CLPM ()
                    Notify (BATC, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XQ25 ()
            }
        }

        Method (BFCC, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\_SB.PCI0.LPCB.EC.BAT0.B0ST)
                {
                    Notify (BATC, 0x81) // Information Change
                }

                If (\_SB.PCI0.LPCB.EC.BAT1.B1ST)
                {
                    Notify (BATC, 0x81) // Information Change
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XFCC ()
            }
        }

        Method (BATW, 1, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If (\BT2T)
                {
                    Local0 = \_SB.PCI0.LPCB.EC.BAT1.XB1S
                    If ((HB1A && !SLUL))
                    {
                        Local1 = 0x01
                    }
                    Else
                    {
                        Local1 = 0x00
                    }

                    If ((Local0 ^ Local1))
                    {
                        \_SB.PCI0.LPCB.EC.BAT1.XB1S = Local1
                        Notify (\_SB.PCI0.LPCB.EC.BATC, 0x01) // Device Check
                    }
                }
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.XATW ()
            }
        }
    }
}