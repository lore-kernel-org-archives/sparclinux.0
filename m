From: Christian Guggenberger
Date: Tue, 03 Feb 2004 16:08:59 +0000
Subject: Re: Oops with 2.6.2-rc3
Message-Id: <1075824539.746.2.camel@bonnie79>
List-Id: <sparclinux.vger.kernel.org>
References: <1075667365.2732.4.camel@bonnie79>
In-Reply-To: <1075667365.2732.4.camel@bonnie79>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2004-02-02 at 14:32, Ben Collins wrote:
> > >>TPC; 0044f334 <__wake_up_common+14/80>   <==> > 
> > >>g2; 004671e0 <wait_for_helper+0/a0>
> > >>o3; 0061bed8 <small_digits.0+0/28>
> > >>ret_pc; 004674f8 <queue_work+f8/120>
> > >>i7; 0044f520 <complete+40/a0>
> 
> My best guess is that this is occuring from call_usermodehelper() or
> request_module() (the only place that wait_for_helper() is referenced is
> in kernel/kmod.c).
> 
> What's the last lines printed before you get this oops? You can try
> disabling kmod to see if that fixes it, but I'd rather find out why it's
> occuring.

Disabling kmod seems to help in this situation, it's been up for 6 hours
in SMP mode now - no oops occured.

 - Christian



