From: Eric Brower <ebrower@usa.net>
Date: Thu, 01 Apr 2004 02:15:01 +0000
Subject: Re: E250 LED indicators
Message-Id: <406B7B25.1000301@usa.net>
List-Id: <sparclinux.vger.kernel.org>
References: <406B2256.6000308@usa.net>
In-Reply-To: <406B2256.6000308@usa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Eric Brower wrote:

[ ... ]
> (i.e. LINUX_REBOOT_CMD_HALT goes to OBP, LINUX_REBOOT_CMD_POWER_OFF goes to 
> OBP).  I may have missed some subtlety, but it seems better to handle 
> this outside of machine_power_off, as a driver MIGHT wish to call that 
> directly under thermal failure scenarios, etc.

Of course, I meant LINUX_REBOOT_CMD_POWER_OFF powers-off.

E

