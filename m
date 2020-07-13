From: David Miller <davem@davemloft.net>
Date: Mon, 13 Jul 2020 23:59:39 +0000
Subject: Re: [PATCH] arch/sparc: Replace HTTP links with HTTPS ones
Message-Id: <20200713.165939.496808182827217356.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200713095351.32997-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713095351.32997-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grandmaster@al2klimov.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Mon, 13 Jul 2020 11:53:51 +0200

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied, thanks.
