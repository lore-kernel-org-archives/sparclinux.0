From: David Miller <davem@davemloft.net>
Date: Sat, 10 Nov 2018 04:36:50 +0000
Subject: Re: [PATCH 2/8] of: Drop full path from Sparc PDT full_name
Message-Id: <20181109.203650.2137044253712054807.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181107223151.14991-3-robh@kernel.org>
        <20181108.191116.1317160901826988583.davem@davemloft.net>
        <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
In-Reply-To: <CAL_JsqLs7P81KiT3b3W5G=qt6JfU0tvM1TKdtJJ5Vq1HSzRW3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robh@kernel.org
Cc: frowand.list@gmail.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Nov 2018 14:30:01 -0600

> That is the intent. With this change we stop storing the full path for
> every node. Everywhere that needs the full path, generates it with the
> %pOF printf specifier. Other than users in arch/sparc converted in
> this series all the users of full_name have been converted already or
> use kbasename(full_name) so they work either way. BTW, I've found a
> couple more, so I'll be sending you a v2.
> 
> And of_pdt_build_full_name for !SPARC does need to be converted too,
> but I'll do that separately.

I would think that, for correctness, you'd need to adjust both functions
at the same time, no?
