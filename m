From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 07 Jan 2004 20:03:31 +0000
Subject: Re: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107200331.GA22976@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040107182529.GK17280@phunnypharm.org>
In-Reply-To: <20040107182529.GK17280@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 07, 2004 at 01:25:30PM -0500, Ben Collins wrote:

> +	  Say Y here if you want to be able to pass default arguments to
> +	  the kernel. This will be overridden by the bootloader, if you
> +	  use one (such as SILO). This is most useful if you want to boot
> +	  a kernel from TFTP, and want default options to be available
> +	  with having them passed on the command line.
> +
> +	  NOTE: This option WILL override the PROM bootargs setting!

I don't really understand the need for this.  Why not just use the
PROM boot arguments if you're booting from TFTP?

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
