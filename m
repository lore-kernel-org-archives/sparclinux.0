From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sun, 14 Oct 2018 07:52:53 +0000
Subject: Re: [PATCH] sparc: vDSO: Silence an uninitialized variable warning
Message-Id: <20181014075252.rurianw2txujyv4b@mwanda>
List-Id: <sparclinux.vger.kernel.org>
References: <20181013102653.GE16086@mwanda>
In-Reply-To: <20181013102653.GE16086@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

On Sat, Oct 13, 2018 at 11:18:20AM -0700, Shannon Nelson wrote:
> On 10/13/2018 3:26 AM, Dan Carpenter wrote:
> > Smatch complains that "val" would be uninitialized if kstrtoul() fails.
> > 
> > Fixes: 9a08862a5d2e ("vDSO for sparc")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   arch/sparc/vdso/vma.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
> > index f51595f861b8..5eaff3c1aa0c 100644
> > --- a/arch/sparc/vdso/vma.c
> > +++ b/arch/sparc/vdso/vma.c
> > @@ -262,7 +262,9 @@ static __init int vdso_setup(char *s)
> >   	unsigned long val;
> >   	err = kstrtoul(s, 10, &val);
> > +	if (err)
> > +		return err;
> >   	vdso_enabled = val;
> > -	return err;
> > +	return 0;
> >   }
> >   __setup("vdso=", vdso_setup);
> > 
> 
> This is probably fine, but it might be cleaner as
> 
>    	err = kstrtoul(s, 10, &val);
> 	if (!err)
> 		vdso_enabled = val;
> 	return err;

I always tell people to do failure handling instead of success handling.
And also I tell people not to make the last if statement in a function
a special case.  Like you see this a lot right:

	ret = frob();
	if (ret)
		return ret;

	ret = frob();
	if (ret)
		return ret;

	ret = frob();
	if (!ret)
		*p = whatever;
	return ret;

If you do failure handling then the success path is at indent level one
and failure handling is two tabs.  But if you mix it up it's not as
clear.  I have never studied this, but my impression from looking at
static analysis over the years is that success handling is error prone.

regards,
dan carpenter
