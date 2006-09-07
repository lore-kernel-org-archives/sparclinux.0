From: Andrew Morton <akpm@osdl.org>
Date: Thu, 07 Sep 2006 03:22:47 +0000
Subject: Fw: [Bugme-new] [Bug 7115] New: openpromfs on 2.6.18-rc stop
Message-Id: <20060906202247.6e609ed7.akpm@osdl.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We seem to have a regression, and David is out of town.

Begin forwarded message:

Date: Wed, 6 Sep 2006 13:36:49 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7115] New: openpromfs on 2.6.18-rc stop working


http://bugzilla.kernel.org/show_bug.cgi?idq15

           Summary: openpromfs on 2.6.18-rc stop working
    Kernel Version: 2.6.18-rc6
            Status: NEW
          Severity: normal
             Owner: platform_sparc64@kernel-bugs.osdl.org
         Submitter: marvin@mydatex.cz


Most recent kernel where this bug did not occur: 2.6.17.11
Distribution: Debian Sarge
Hardware Environment: Sun E250
Software Environment: Sarge 
Problem Description:
When I try change input device or another prom config param
I get Invalid argument and kernel returns EINVAL. The same think on 2.6.17.2 works

Steps to reproduce:
echo "keyboard' > /proc/openprom/options/input-device
Inavlid argument

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
