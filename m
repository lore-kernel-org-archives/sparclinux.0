From: "Art Haas" <ahaas@airmail.net>
Date: Sun, 01 Aug 2004 20:04:18 +0000
Subject: Re: Question about recent copy_user.S change
Message-Id: <20040801200418.GC7321@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040801192158.GB7321@artsapartment.org>
In-Reply-To: <20040801192158.GB7321@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Aug 01, 2004 at 12:57:41PM -0700, William Lee Irwin III wrote:
> 
> Could you post some system log information about the SCSI errors?
> 

The next time one happens I'll see what I can recover. Usually the
machine is just sailing along happily, then BLAM! From memory I recall
seeing messages like "SCSI Reset", but I don't have any files I can send
along now. Also, the hard-drives in the machine get remounted as
read-only, so all errors usually sent to system logs fail. Once the
error happens the machine is essentially dead and needs rebooting via
the magic Stop-A key combo.

I'd be game for running some filesystem stressing programs if someone
can suggest a good means of capturing the output on a remote machine
when/if the SCSI controller goes boom.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
