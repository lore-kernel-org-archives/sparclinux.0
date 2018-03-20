From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Tue, 20 Mar 2018 03:42:00 +0000
Subject: Re: sparc_pipe(2)
Message-Id: <20180320034200.GZ30522@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180319.211125.314781796727440151.davem@davemloft.net>
In-Reply-To: <20180319.211125.314781796727440151.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 19, 2018 at 09:11:25PM -0400, David Miller wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Tue, 20 Mar 2018 00:12:24 +0000
> 
> > Am I missing something here, or is it simply that the thing predates
> > current_pt_regs()?
> 
> It probably just predates current_pt_regs(), yes.

OK...  Another fun question in the same area:
asmlinkage long sys32_ftruncate64(unsigned int fd, unsigned long high, unsigned long low)
{
        if ((int)high < 0)
                return -EINVAL;
        else
                return sys_ftruncate(fd, (high << 32) | low);
}

Is there any reason we want to check high right there?  After all,
sys_ftruncate() will produce exactly that on MSB of its second
argument set...  The same goes for sys32_truncate() - sys_truncate()
will yield -EINVAL on negative loff_t.
