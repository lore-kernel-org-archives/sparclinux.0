From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 23 Sep 2010 14:14:01 +0000
Subject: Re: Question about interrupt processing on Sparc64
Message-Id: <20100923141401.GA30716@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
In-Reply-To: <E1OymHM-0000pp-00.alexvm12e-mail-ru@f159.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Sep 23, 2010 at 05:56:04PM +0400, Alex Mach wrote:
> Hello,
> 
> Why ttable.S and sun4v_ivec.S aren't linked to kernel in Makefile at /arch/sparc/kernel? As I understend these files are necessary for interrupt processing (sun4v_dev_mondo() and handle_irq() functions).
> 
They are both included by: head_64.S

	Sam
