From: "C.Newport" <crn@netunix.com>
Date: Sun, 07 Mar 2004 20:18:35 +0000
Subject: Status of Sun4d and Pluto (SSA1x0)
Message-Id: <200403072018.35650.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


First a bit of history for the list :-
Sun4d worked UP only with 2.2.20, SMP has never worked.
Sun4d does not work in 2.4.x or 2.6.x
This is due to lack of documentation, I have traced a contact in Sun
who has the information and passed this to Keith who has added it
to his to-do list. Please be patient.
This applies to SparcServer 1000, 1000E, 2000, 2000E and some 
rare Sparc-based Cray machines.

Now the new content :-
Most Sun4d machines and many others were sold with Sparc Storage 
Arrays SSA1x0. These arrays need the soc and pluto drivers.
The last supported Solaris release is Solaris 8, test your hardware 
with this before blaming Linux. The SSA1x0 is easy to identify, it
has an LCD status panel on the left and 3 pullout drawers each 
holding 10 drives. Most were supplied with 2Gb or 4Gb drives, later
models have been known to work with 9Gb and 18Gb.


Status of soc and pluto :-
Sun4d and Sun4u work using the instructions at 
http://www.netunix.com/fibrechan.html using 2.2.20 (tested on SS1000E
and Ultra 1).
Sun4m does not work, the array seems to initialise then lose carrier this
smells like a lost IRQ to me but this is unconfirmed.
The soc and pluto drivers are broken in 2.4.x and 2.6.x, probably because
they have never been updated.

Implications :-
We need to get the soc and pluto stuff working because many SS1000
and Ex000 systems were sold with no SCSI devices and boot from these
arrays.




