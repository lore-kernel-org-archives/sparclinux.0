From: Pete Zaitcev <zaitcev@redhat.com>
Date: Wed, 31 Mar 2004 01:51:10 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040330175110.38eb7f2a.zaitcev@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Mar 31, 2004 at 12:25:25AM +0000, C.Newport wrote:

> All supported 32bit sparc machines come with a sunlance NIC, so
> why would you want this as a module ?. You are always going to
> need it.

JavaStation-NC, JavaEngine-1, CP-1200 all have HME. Solaris never
supported those, but Linux is better.

> There is a slightly more obscure issue here - Not all Sun machines
> have a working CD drive so the ability to boot from the network for
> both installations and troubleshooting is highly desireable. 
> Booting from a device which needs a module is not a good idea.

On sparc, initrd is easy to piggyback onto the kernel, so it should
pose no problem to netboot over a modular sunlance.
Please refer to arch/sparc/boot/piggyback.c.

-- Pete
