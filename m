From: Donald Parsons <dfp10@capital.net>
Date: Sat, 08 Apr 2006 19:24:37 +0000
Subject: Problem installing K3b into suse7.3-sparc
Message-Id: <6.1.2.0.0.20060408151513.019d6788@pop.logical.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!
I am trying to install one or other of the update binaries of  k3b and 
getting similar failures with each.
My attempts to compile the sources have also not been successful.
There seems to be insufficient suse-sparc files to patch up the install.
After installing rpm k3b-0.9-3.sparc.rpm I get:

dfp10@paxultra:/opt/kde3/bin> ./k3b
kio (KSycoca): WARNING: Found version 40, expecting version 61 or higher.
kio (KSycoca): WARNING: Outdated database found
kio (KSycoca): WARNING: Found version 40, expecting version 61 or higher.
kio (KSycoca): WARNING: Outdated database found
k3b: WARNING: KDE detected X Error: BadMatch (invalid parameter attributes) 
\x08
   Major opcode:  *
kio (KSycoca): WARNING: Found version 40, expecting version 61 or higher.
kio (KSycoca): WARNING: Outdated database found
k3b: WARNING: KDE detected X Error: BadMatch (invalid parameter attributes) 
\x08
   Major opcode:  *
dfp10@paxultra:/opt/kde3/bin> rpm -q k3b
k3b-0.9-3
Also, on the screen:Could not find mime type: application/octet-stram
                                             no Mime Types installed!
Could someone give me assistance with this?
Thanks
Donald Parsons
dfp10@capital.net






