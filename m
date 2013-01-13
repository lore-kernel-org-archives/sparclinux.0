From: Chen Gang <gang.chen@asianux.com>
Date: Sun, 13 Jan 2013 09:48:42 +0000
Subject: [Regression] arch/arch: about pach and suggestions for strcpy
Message-Id: <50F282FA.5030309@asianux.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello Sam Ravnborg:

  firstly, I make an apology for the original impolite mails.
    mutual respect is the base for communicating with each other,
    so I should understand that get non-reply for original mails.

  since I am in upstream (start Nov 2012):
    I have made some patches and suggestions successful.
    but I also made some technical faults which noted below:

      A) net/atm:  "%pM means format this pointer as a mac address", thank Chas Williams
      B) net/tipc: "TIPC_MAX_IF_NAME is not TIPC_MAX_LINK_NAME", thank Xue Ying
      C) net/core: "not see 'if (PAGE_SIZE - len < 3)' ", find by myself
      D) MAINTAINER: "tty != serial",  thank Jiri Slaby and Joe Perches
      E) drvers/staging/telephony: "torvalds' tree is different with next tree", thank devendra.aaru
      F) drivers/staging/telephony: "we should probably fix it for older kernels", thank Dan Carpenter
      G) drivers/usb/core: "doing DMA on the stack violates the DMA rules", thank Oliver Neukum
      H) arch/blackfin/kernel: "%8s is used to take up the same space", thank Mike Frysinger and Steven Miao
      I) drivers/usb/host: "usb_hcd_giveback_urb set urb->hcpriv to NULL", thank Alan Stern
      J) net/atm:  "the max return value of snsprintf is the 2nd param - 1 or 0", find by myself
      K) fs/ext3:  "on-disk encoding does not include e_id, if not ACL_USER, ACL_GROUP", thank Theodore Ts'o
      L) fs/ext3:  "ACL_USER_OBJ ACL_USER*[1] ACL_GROUP_OBJ ACL_GROUP*[1] ACL_MASK[2] ACL_OTHER"
                   [1] Where * is the regexp sense of "0 or more times"
                   [2] Only if there is at least one ACL_USER or ACL_GROUP tag; otherwise skip ACL_MASK.
                         thank Theodore Ts'o
                   [2] If ACL_USER or ACL_GROUP is present, then ACL_MASK must be present.
               	         thank Jan Kara
      M) drivers/net/wireless/ipw2x00: "duplicate buffer to print different contents, at the same time"; find by myself

     I will still continue, since we are all improving, and our goal is to provide contributes to outside.

   I understand you are really busy:
     I still suggest you to help checking the original patch and suggestions, when you have free time.
     it is my fault, but they are innocence.


   at last, sorry again for my original impolite mails.

   :-)

   Regards

gchen
