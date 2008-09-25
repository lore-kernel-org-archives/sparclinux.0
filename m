From: Meelis Roos <mroos@linux.ee>
Date: Thu, 25 Sep 2008 13:30:05 +0000
Subject: What is needed for reviving socal?
Message-Id: <Pine.SOC.4.64.0809251625071.24923@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

what is needed to revive the socal driver in Linux?

As I understand, it worked some time ago with some version of firmware 
that had to be cut from a Solaris patch. Then after some other changes 
in Linux it stopped working and nobody investigated until it was thrown 
out. Was there something more? I seem to remember that not all firmware 
versions worked (and the latest didn't work either), but that might have 
been soc, not socal.

What would the soft FC stack need - rewrite to use the scsi transport 
layer? What would such arewrite mean?

What experience is needed to do that? We are considering doing it here 
with a interested stundent, Kait Elbe (CC-d).

-- 
Meelis Roos (mroos@linux.ee)
