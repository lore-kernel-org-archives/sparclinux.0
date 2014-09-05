From: David L Stevens <david.stevens@oracle.com>
Date: Fri, 05 Sep 2014 16:46:24 +0000
Subject: Re: commit 8c86e70acead629aacb4afcd818add66bf6844d9 hangs SPARC64 LDOMs
Message-Id: <5409E8E0.1070007@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5409D2C3.6010806@oracle.com>
In-Reply-To: <5409D2C3.6010806@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 09/05/2014 12:23 PM, Vivek Goyal wrote:
> 
> Hi David,
> 
> I put one more commit on top in -rc3 to fix UML crash.
> 
> commit 800df627e2eabaf4a921d342a1d5162c843b7fc2
> Author: Vivek Goyal <vgoyal@redhat.com>
> Date:   Fri Aug 29 15:18:29 2014 -0700
> 
>     resource: fix the case of null pointer access
> 
> 
> Can you try applying this patch on top of net-next and see if helps
> fix the issue.
> 
> If not, then it probably is a different issue. Is there anything on
> the console? I will need to know some more information to figure out
> what's wrong.

I'll try it out. I was investigating further, too, by putting pieces
of your patch in until it broke, but haven't hit the problem yet. No,
there's nothing on the console.

						+-DLS

