From: Joshua Kwan <joshk@triplehelix.org>
Date: Thu, 16 Sep 2004 05:54:14 +0000
Subject: [SPARC32] sunzilog problems with lots of output at once
Message-Id: <cib9qa$elu$1@sea.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig00678CA5D1B8D7ABFC4AEC9B"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00678CA5D1B8D7ABFC4AEC9B
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I'm experiencing a problem with the sunzilog driver on 2.6.8.1 on 
sparc32. Recently I did:

fantaisie:~# dmesg

and the serial console stopped receiving output. I had to ssh in and 
kill the parent process (bash) for things to start working again.

Alternatively, ptracing the process was enough to un-wedge it. (strace 
-p). Here are the first few lines of the strace output:

# strace -p 966
Process 966 attached - interrupt to quit
ioctl(0, TCSETAF or SNDCTL_TMR_SELECT, {B38400 opost isig -icanon -echo 
...}) = 0
ioctl(0, TCXONC, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, TCSETAF or SNDCTL_TMR_SELECT, {B38400 opost isig icanon echo 
...}) = 0

-- 
Joshua Kwan

--------------enig00678CA5D1B8D7ABFC4AEC9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQUkqiaOILr94RG8mAQL0VRAAgWfintDMCSnOBXgmNYqipesO4PMIcuAP
L4L2yjWWujWofX1xz+4eWCG3Bvl06qnHOVgPlygLLbZQRlmvSCzWwt1h2EaW1g6j
QHLcT21uGax+P+krKuFcUcc3IzQE8WoM96E32Y0Ij+hwJzUimrVqIjSeoPvLAT8/
cBdxkHI4sp4nzUfgKGUxzOBZoJZ12mllc0q2MrWMoCg2QqNl/YD+tkiy09itbyo+
8u8uz8AHZFPLSBFpHDm8brkO9I9bwbk7yxo3SNvERT1yihcRTyF953TggvKoKPPl
1LvFNUECeoSzNQWj/xCkam3bex7E333vJQoB8B2DaFgVL+8AwPct8BTxYxMUEU7Y
6paabY4fcFB56NpEvCdc6E6CqCuyaB2LazlFF3CUxN2rtHFy7xoja8lYfcGZqFxf
L3QMuDYAwvLvLgvq+PutpLGLN2JN7fP4OqVUYhjm9X9rUDaLCDy+9y4cQN0SS5IX
sYrdW0lEcNCgCgr1ttTRG1rIyXDMJ0EODJQFDcytYLlADHIJdpMxo/4pH0IApkB6
+/UMHR5JAuvcRjRR8FC3hrNEGLIm7gqj7i7tg/3eyq2nfkXE5Dira8404AKKEREy
pcw88JlJvJ8/z+twy9gSRkW5bNfKkF3i6x6cIbsgbkvUj6bpKy9OsTEIgSHBHmnY
bTB5gB0fYoE=
=0cc3
-----END PGP SIGNATURE-----

--------------enig00678CA5D1B8D7ABFC4AEC9B--

