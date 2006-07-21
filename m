From: Raymond Burns <rayburns@comcast.net>
Date: Fri, 21 Jul 2006 03:50:09 +0000
Subject: Re: sparc32 git tree
Message-Id: <Pine.LNX.4.10.10607202019520.10727-100000@coalcreekmill.cm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <44BBB08C.3090004@mc.net>
In-Reply-To: <44BBB08C.3090004@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 19 Jul 2006, David Miller wrote:

> Let's do the instance enumeration like the following patch.
> It should do the right thing and it shouldn't mark some of
> your sun4d zilogs as being for the keyboard/mouse :)

This is on target, lets see that the other subarchitectures are
working. 

Attempts to remove request_irq() from zs_probe have failed and I still
have a NULL check in the interrupt service routine.

Currently it does initialize the zs subsystem, I need to see some
details available in user land before I can claim no tuning needed.


Working this from a serial console has it's challanges.

Thanx
  Ray


