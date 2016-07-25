From: alexmcwhirter@triadic.us
Date: Mon, 25 Jul 2016 22:14:28 +0000
Subject: Re: QLogic PTI firmware
Message-Id: <fdca2bc4e057d30a2981a5237e2428ef@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Well i'm bringing this email back from the dead, original thread can be 
found here https://lists.debian.org/debian-sparc/2013/01/msg00008.html

In a nutshell the qlogicpti driver isn't handling traffic demands very 
well, the request queue will overflow and the system will panic. Just 
letting a box idle for a few days will result in this issue popping up. 
You can accelerate it by doing a large amount of disk I/O.

In particular, we are hitting this code in qlogicpti.c

toss_command:
         printk(KERN_EMERG "qlogicpti%d: request queue overflow\n",
                qpti->qpti_id);

         /* Unfortunately, unless you use the new EH code, which
          * we don't, the midlayer will ignore the return value,
          * which is insane.  We pick up the pieces like this.
          */
         Cmnd->result = DID_BUS_BUSY;
         done(Cmnd);
         return 1;
}

Does anyone have any input on this? Fixing this would help stabilize a 
ton of early sparc64 machines, almost everything with a scsi controller 
around the US2 days use and isp1000 card.

