From: Julian Calaby <julian.calaby@gmail.com>
Date: Sat, 08 Jan 2011 00:11:59 +0000
Subject: Re: [PATCH] use __devexit not __exit in n2_unregister_algs fixes
Message-Id: <AANLkTikNOTLjy-ui0X_BtTEWqWxaGkb-RdCsW4YwiF2_@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1294257371-19695-1-git-send-email-dennis@ausil.us>
In-Reply-To: <1294257371-19695-1-git-send-email-dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jan 6, 2011 at 06:56, Dennis Gilmore <dennis@ausil.us> wrote:
> From: dennis <dennis@daedalus.ausil.us>
>
> thanks to kylem for helping with debugging

Better, but you're still missing your Signed-Off-By and this isn't a
proper patch description - you should, at least, include the error you
were getting.

Also, as this patch is for crypto code, you should probably send it to
their mailing list instead of sparclinux. If you look in the
MAINTAINERS file, you should be able to find the email addresses of
the relevant people.

Thanks,

-- 

Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
