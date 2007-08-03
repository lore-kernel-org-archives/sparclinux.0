From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Fri, 03 Aug 2007 14:14:41 +0000
Subject: Re: Kernel compile errors
Message-Id: <1186150481.9748.269.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <46B3345F.7060004@gmail.com>
In-Reply-To: <46B3345F.7060004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Fri, 2007-08-03 at 15:57 +0200, Sunil Amitkumar Janki wrote:
> I have just bought a Sun server for running and compiling
> a SPARC Linux kernel and distribution. I've tried to compile
> a 32-bit kernel but I'm getting errors. I will also try to build
> a 64-bit kernel when I get the 64-bit tool chain right.

Note that a 32-bit kernel (sparc/) won't boot on a sparc64 system. You
need to build a 64-bit kernel to have any hope of success.

~spot

