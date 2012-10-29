From: marxdenl <marxdenl@gmail.com>
Date: Mon, 29 Oct 2012 09:44:23 +0000
Subject: Re: Question about hibernation on sparc64
Message-Id: <1351503863.6005.15.camel@dlw-desktop>
List-Id: <sparclinux.vger.kernel.org>
References: <80041334231315@web149.yandex.ru>
	 <1351437674.2747.9.camel@dlw-desktop> <1862521351464447@web28d.yandex.ru>
In-Reply-To: <1862521351464447@web28d.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-pm@vger.kernel.org

On Mon, 2012-10-29 at 02:47 +0400, Kirill Tkhai wrote:
> 
> 28.10.2012, 19:21, "marxdenl" <marxdenl@gmail.com>:
> > On Thu, 2012-04-12 at 15:48 +0400, Kirill Tkhai wrote:
> >
> >>  Hello!
> >>
> >>  I bumped on the fact that there is no hibernation support
> >>  on sparc64. It's possible that the process of its porting
> >>  will become interesting for me in the future, but I'm not
> >>  exactly sure at the moment.
> >
> > hi, I'm also intersting to do that. How is that going?
> >
> > Waiting for reply:)
> 
> Hi, I did nothing. You may dive into this if you want.

I enabled CONFIG_HIBERNATION, implemented 'swsusp_arch_suspend'
which saves some general registers (%g,%i,%o,%l) and call 
'swsusp_save', and 'swsusp_arch_resume' which load 'pblist' and
restore those registers.

Now my T2 can create hibernation images, but after restore the image, 
it crashes. If there's something I missed?

Thanks!

--
Linwen Deng 

