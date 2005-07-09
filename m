From: Ulrich Teichert <krypton@ulrich-teichert.org>
Date: Sat, 09 Jul 2005 18:45:58 +0000
Subject: Flashing of an Ultra2?
Message-Id: <200507091845.j69IjwBL027851@arbas.nms.ulrich-teichert.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I recently bought 2 300 Mhz UltraSparcII modules on Ebay to put into
my Ultra2. After setting the jumper, the box boots fine with the
CPUs and I am able to start the kernel (2.4.25, SMP).

However, I have to update the PROM, the CPUs are only running at
180 Mhz. OK, understandable, because SUN says 3.11.2 or later and
I have 3.1.5. So, I tried to netboot the flash binary (I have no
Solaris) after I popped in the old CPUs:

Sun Ultra 2 UPA/SBus (2 X UltraSPARC 168MHz), No Keyboard
OpenBoot 3.1.5, 384 MB memory installed, Serial #8585685.
Ethernet address 8:0:20:83:1:d5, Host ID: 808301d5.
                                                                     =20
{0} ok boot net flash-update-Ultra2-09
Boot device: /sbus/SUNW,hme@e,8c00000  File and args: flash-update-Ultra2-09
Using Onboard Transceiver - Link Up.=20
d3000=20
Server  IP address: 192.168.22.1=20
Client  IP address: 192.168.22.27=20
Fast Instruction Access MMU Miss

Ugh. I tried this in various ways, but never succeeded. But after unpacking
104169-08.tar.Z, I ended up with this directory:

arbas:~/hardware/sun/firmware/104169-08> ls
802-3233-20.ps*              flash-update-Ultra2-05*
README.104169-08             flash-update-Ultra2-06*
flash-update-Ultra2-01*      flash-update-Ultra2-07*
flash-update-Ultra2-02*      flash-update-Ultra2-08*
flash-update-Ultra2-03*      flash-update-Ultra2-09*
flash-update-Ultra2-04*      flash-update-Ultra2-latest@

So, the binary in question is flash-update-Ultra2-09, or what?

Now, more questions: would it be possible to use the PROM flashing module
from Linux? I can load the necessary modules just fine:

Module                  Size  Used by    Not tainted
flash                   2304   0  (unused)
openpromfs             12864   1=20
openprom                5140   0  (unused)
vfat                   11600   0  (unused)
nfsd                   76472   0  (unused)
msdos                   6056   0  (unused)
fat                    37480   0  [vfat msdos]
lp                      8616   0  (unused)
parport                35664   0  [lp]
nbd                    21392   0  (unused)

Or should I first upgrade the kernel? 2.4.25 is pretty old.
And what would be the magic lines to start the flashing? How should
I prepare the data for flashing?

Thanks a lot for any pointer,
Uli
--=20
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Cauchemar (Op=E9ration=
 S)
