From: Balint Cristian <rezso@rdsor.ro>
Date: Mon, 16 Feb 2004 15:28:52 +0000
Subject: Re: [Q] sun mouse on 2.6.x
Message-Id: <200402161728.52737.rezso@rdsor.ro>
List-Id: <sparclinux.vger.kernel.org>
References: <20040215002314.GH19221@net-ronin.org>
In-Reply-To: <20040215002314.GH19221@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Monday 16 February 2004 15:59, C.Newport wrote:

> What happens if you power down and cold boot rather than doing
> a warm reboot.

I can figure out 3 cases to let no doubt of the problem:

	If power down and machine halt its ATX power and than power on in 2.6
will never work the mouse, even i reboot lot of times in 2.6 after that !

	If power down completly, than power on machine in 2.4 of course will work well
can reboot in 2.4 anytimes I want and will work.

	If  power down, than power on machine in 2.4 than any time I reboot
In 2.6 will work well.


>
> I have a similar issue here on a triple boot Linux/Windoze/Solaris
> laptop, rebooting from windows and selecting solaris always goofs
> up, it seems that some hardware is left in an odd state which gets
> correctly initialised by the bios only if I do a cold boot.

	?!? i think is not the case of this, the fact is that 2.4 was worked well and 
now latest 2.6.x series has an clear issue of this mouse init problem on U10/U5.

>
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
