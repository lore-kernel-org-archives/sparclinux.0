From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Feb 2016 20:14:45 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <20160221201445.GB24601@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Added Al Viro, as author of the commit git bisect pointed out.

On Sun, Feb 21, 2016 at 01:52:55PM -0500, Alex McWhirter wrote:
> On 02/14/2016 07:02 PM, Alex McWhirter wrote:
> > I having a strange issue where using any 4.X kernel causes rsync to
> > appear to die on a select syscall. Not sure why, maybe it's getting a
> > wrong file descriptor or something. Unfortunately this starts pushing
> > outside of my knowledge level of linux so bear with me. This is on a Sun
> > V215 but i have also tested it on a Sun Blade 150 and a Sun Ultra 45
> > with the same results. These are all sun4u boxes of course, i haven't
> > tried any sun4v boxes. I''l try to spin up a T5120 this week and find
> > out if it's also an issue on sun4v.
> >  
> > Here's what I've tested.
> >
> > 3.14.58 "gentoo" - Works
> > 3.18.26 "vanilla"  - Works
> > 4.1.15   "gentoo" - Dead
> > 4.1.17   "vanilla"  - Dead
> > 4.4.1     "vanilla"  - Dead
> >
> > I don't mind hacking away at kernel sources if anyone can point me in
> > the right direction. It's also worth noting that this only happens when
> > the folder i am attempting to rsync is significantly large in regards to
> > the amount of sub-folders and files. The Gentoo portage tree in particular.
> >
> > Attached is the strace output of a failing rsync job.
> >
> >
> 
> I've traced this down a bit further.
> 
> Kernel 3.18.26 is working but 3.19.0 is not. Git bisect traced it down
> to this commit.
> 
> e5a4b0bb803b39a36478451eae53a880d2663d5b is the first bad commit
> commit e5a4b0bb803b39a36478451eae53a880d2663d5b
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Mon Nov 24 18:17:55 2014 -0500
> 
>     switch memcpy_to_msg() and skb_copy{,_and_csum}_datagram_msg() to
> primitives
>    
>     ... making both non-draining.  That means that tcp_recvmsg() becomes
>     non-draining.  And _that_ would break iscsit_do_rx_data() unless we
>         a) make sure tcp_recvmsg() is uniformly non-draining (it is)
>         b) make sure it copes with arbitrary (including shifted)
>     iov_iter (it does, all it uses is iov_iter primitives)
>         c) make iscsit_do_rx_data() initialize ->msg_iter only once.
>    
>     Fortunately, (c) is doable with minimal work and we are rid of one
>     the two places where kernel send/recvmsg users would be unhappy with
>     non-draining behaviour.
>    
>     Actually, that makes all but one of ->recvmsg() instances
> iov_iter-clean.
>     The exception is skcipher_recvmsg() and it also isn't hard to convert
>     to primitives (iov_iter_get_pages() is needed there).  That'll wait
>     a bit - there's some interplay with ->sendmsg() path for that one.
>    
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> :040000 040000 b4d6852e73bd3d54a30b72441c8e35f79dc07266
> f0b90ef68ee891b38decf571247002c1d7fad519 M      drivers
> :040000 040000 8ba2fadf14c05a86a7c21448dac52fed661a2e12
> 0051ec4b6f273dbaed2bed21e4fddd48664d5afa M      include
> :040000 040000 d28e72369891521f7d853b30612a32cf65a27f6b
> b828e68082a6fed2cf240aad4b365c5808928122 M      net
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
