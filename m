From: alexmcwhirter@triadic.us
Date: Fri, 04 Mar 2016 20:24:30 +0000
Subject: Re: Kernels 4.+ are breaking =?UTF-8?Q?rsync=3F?=
Message-Id: <e27cb22ab17f1f6e5b795c55b90daa01@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Reverting commit e5a4b0bb803b39a36478451eae53a880d2663d5b does indeed 
resolve the problem on my side.

I do find it odd that the Debian port seems to be working fine. I'm 
going to give the latest kernel on a try on this box. Previously i had 
only tried up to the latest rendition of 4.1. If it's still broken I 
will boot up Debian and see what's going on. Hopefully it isn't hardware 
specific "This is a cheetah box IIRC"


