From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 05 Jun 2007 08:30:42 +0000
Subject: sun4c random Illegal instruction faults
Message-Id: <Pine.LNX.4.61.0706050922190.6872@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I am doing testing on linux-2.6.22-rc3 and it is giving me ramdom Illegal 
instruction faults.

I have tested the system with linux-2.6.20.9 and it does not have the 
issue (same ptep_set_access_flags patch applied to both kernels).

Anybody got any bright ideas as to what the cause might be?

(git bisecting from v2.6.20 is a pig as there is a commit in the 
middle that breaks the sparc32 build for most of the commits between 
v2.6.20 and v2.6.21).

Regards
 	Mark Fortescue.


