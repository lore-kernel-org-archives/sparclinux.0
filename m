From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 19 May 2005 17:12:11 +0000
Subject: Re: 2.6.11.10 failure on Hypersparc sparc32 [was: Re: sparc32 2.6
Message-Id: <1116522731.3502.256.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0505190111530.13987@bobcat>
In-Reply-To: <Pine.LNX.4.61.0505190111530.13987@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2005-05-19 at 12:41 -0400, Jurij Smakov wrote:

> Interesting. I guess that it actually uses initramfs capability to load 
> cpio archives into ramdisk. We are planning this transition at some point, 
> but at the moment cramfs/ext2 initrds is what is used.

I'm not aware that cramfs initrds have ever worked properly with 2.6...
I could be wrong. I thought the direction was initramfs with 2.6.
Perhaps this is a good time to make that transition? :)

~spot
-- 
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

