From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 02 Jan 2011 00:39:36 +0000
Subject: Re: [PATCH 8/9] sparc: rename piggyback_32 to piggyback
Message-Id: <AANLkTinQrr5002RJQv-c5nNjEWfuVfsRNaF4BTO2noDF@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1293915632-4596-8-git-send-email-sam@ravnborg.org>
In-Reply-To: <1293915632-4596-8-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 2, 2011 at 08:00, Sam Ravnborg <sam@ravnborg.org> wrote:
> Now that we use the same piggyback for 32 and 64 bit
> we can drop the _32 suffix.
> Include some trivial unification in the Makefile
> now that 32 and 64 bit can share the same piggyback command.

Looks good.

I was considering unifying the makefile, but the crazy stuff at the
bottom of the SPARC32 section scared me off.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
