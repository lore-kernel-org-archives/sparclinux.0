From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 17 May 2006 23:10:51 +0000
Subject: Re: klibc and SPARC
Message-Id: <446BAD7B.4050908@zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <e4g1ho$dae$1@terminus.zytor.com>
In-Reply-To: <e4g1ho$dae$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> How I answer this depends upon why you're moving this out of the
> kernel in the first place :-)

The goal is mainly to get rid of a bunch of complex code that doesn't have to be in the 
kernel, like nfsroot.

> I can understand moving as much functionality as is reasonably
> possible into userspace via klibc, but for something like this which
> has weird dependencies if you move it into userspace and will
> undoubtedly force the enabling of what is normally an optional
> feature, I don't see moving it into userspace as being so wise.

OK, so that would make it an ad hoc thing.  That's not too horrible in itself; I just 
wondered if it would make sense to use an already existing feature.

However, there are a number of theoretically optional features in the kernel kernel which 
kinit does depend on, in particular sysfs and procfs -- without which it would be largely 
impossible.  It doesn't mean sysfs and procfs are mandatory, but it does mean that you 
have to provide your own initramfs if you don't want to include them.

Of course, unlike say openpromfs, very little userspace code will actually function 
without procfs, and increasingly sysfs, so it's not exactly a requirement imposed by kinit 
alone.

> That being said, openpromfs is the preferred thing to use if
> you have to make a choice.

Well, I'm happy to do it either which way.  I'll go ahead and write up an ad hoc solution 
for this case, unless it turns out to actually be bigger than one of the generic codes.

	-hpa
