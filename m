From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 12 Dec 2010 23:15:47 +0000
Subject: Re: [RFC 4/8] sparc: prom: Remove unused definition of prom_stdin
Message-Id: <AANLkTik0Nq0bgc7OYJWU4tJJNHhzpHaZqEFOpbo9kh5L@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC2E.9050300@julian.is-a-geek.org>
In-Reply-To: <4CF9BC2E.9050300@julian.is-a-geek.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 13, 2010 at 09:52, David Miller <davem@davemloft.net> wrote:
> From: Julian Calaby <jcalaby@julian.is-a-geek.org>
> Date: Sat, 04 Dec 2010 14:57:34 +1100
>
>> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>
> prom_stdin is still assigned (unnecessarily) in init_64.c so we
> really can remove this thing completely.
>
> I'll make a patch which does that.

Cool, thanks!

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
