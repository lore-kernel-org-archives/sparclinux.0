From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 13:40:53 +0000
Subject: Re: [PATCH] Fix p9100 framebuffer in 2.6
Message-Id: <1128606053.2140.134.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1115651371.3017.58.camel@localhost.localdomain>
In-Reply-To: <1115651371.3017.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2005-05-09 at 10:09 -0500, Tom 'spot' Callaway wrote:
> The attached patch fixes the p9100 framebuffer so that text is viewable
> (not black on black, like it was before the patch). The linux logo
> displays for a very short period of time, then is replaced by a grey
> box. This leads me to believe that this framebuffer would have problems
> in X, but since there hasn't been a weitek driver for X in several
> millennia, this isn't something that I can confirm or deny.
> 
> But this patch does get color console working on my SPARCbook 3TX.
> 
> Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

This patch has not been applied... it's obviously at least partially
correct, as without it, you can't get a viewable console at all. Should
I be submitting it somewhere else?

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

