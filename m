From: carbonated beverage <ramune@net-ronin.org>
Date: Mon, 16 Feb 2004 07:50:18 +0000
Subject: Re: [Q] sun mouse on 2.6.x
Message-Id: <20040216075018.GA31092@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040215002314.GH19221@net-ronin.org>
In-Reply-To: <20040215002314.GH19221@net-ronin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 15, 2004 at 03:05:48PM +0200, Balint Cristian wrote:
> 	If i power on from standby it happens that always not work,
> but if I boot in 2.4 kernel than reboot in 2.6 it always works !!
> 
> 	So 2.4 has someting that 2.6 miss at one point, it initialize
> someting that 2.6 not, ant that init is reboot independent.

Hmm... tried this, and whaddya know.  It works.  So somehow, 2.4.x
is initializing the hardware state in a way 2.6.x isn't.  Thanks,
I'll go and see what's different between the two...

-- DN
Daniel
