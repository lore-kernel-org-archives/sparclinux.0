From: Balint Cristian <rezso@rdsor.ro>
Date: Sun, 15 Feb 2004 13:05:48 +0000
Subject: Re: [Q] sun mouse on 2.6.x
Message-Id: <200402151505.48062.rezso@rdsor.ro>
List-Id: <sparclinux.vger.kernel.org>
References: <20040215002314.GH19221@net-ronin.org>
In-Reply-To: <20040215002314.GH19221@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sunday 15 February 2004 02:23, carbonated beverage wrote:
> Hi all,
> 
> I'm unable to get the mouse recognized by gpm or X under 2.6.x
> bk pulls although the kernel recognizes it.  I'm using the input
> layer and tried specifying /dev/input/{mice,mouse0} to both gpm
> and X.  /dev/psaux (I have the legacy option turned on) doesn't
> work either.
> 
> The kernel seems to find it fine:
> 
> mice: PS/2 mouse device common for all mice
> input: Sun Mouse on su/serio0
> 
> And everything's enabled in .config:
> 
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X24
> CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=m
> CONFIG_MOUSE_SERIAL=m
> 
> But nothing from gpm or X.
> 
> I'm using a debian/testing setup on an Ultra 5.
> 
> Anyone have a suggestion on how to go about debugging this?

	As comment, (already reported on list) on U10 is the same phenomena,
with the same case/experiment.
	
	But one interesting thing:

	If i power on from standby it happens that always not work, but if I boot in 2.4 kernel than reboot
in 2.6 it always works !!
	So 2.4 has someting that 2.6 miss at one point, it initialize someting that 2.6 not, ant that init is reboot independent.

cristian,
 

> 
> -- DN
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
