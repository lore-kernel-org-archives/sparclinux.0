From: Meelis Roos <mroos@linux.ee>
Date: Sun, 23 Apr 2017 15:57:18 +0000
Subject: Spontaneous reboots seem to have been fixed
Message-Id: <alpine.LRH.2.20.1704231850570.29170@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For a long time I have had a problem on some of my sparc64 kernel 
machines during kernel module linking (creating .mod.o and/or .ko) with 
make -j4 but usually not with plain make.
 
Usually this resulted in spontaneous reboot (on V210 and V240 and 
E420R), sometimes causing hang on E420R. I was trying to bisect kernel 
configurations to find it but that was hard. THP was always on.

However, as of commit 544f8f935863c5a9ca3e34306ea3316095e7b7bf (sparc64: 
Fix hugepage page table free) this seems to have been fixed - all three 
machines behave well for days of compilation.

Is it probable that this was the culprit, or did I just stumble on 
something else that prevents the bug from happening?

-- 
Meelis Roos (mroos@linux.ee)
