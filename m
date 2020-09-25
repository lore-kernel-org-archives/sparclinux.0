From: David Miller <davem@davemloft.net>
Date: Fri, 25 Sep 2020 20:45:22 +0000
Subject: Re: [RFC] openprom: Fix 'opiocnextprop'; ensure integer conversions; use string size
Message-Id: <20200925.134522.130367831393016171.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a5515efeaad94666a87f264dbf65bdbd@gmail.com>
        <20200914.170321.1710628974878239639.davem@davemloft.net>
        <859f327c79da4d9c945e50568805456c@gmail.com>
In-Reply-To: <859f327c79da4d9c945e50568805456c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mfwitten@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Michael Witten <mfwitten@gmail.com>
Date: Fri, 25 Sep 2020 20:20:20 -0000

> Are we trying to improve the code or not?

Do you want me to apply your patch or not?

I want to see the most minimal code change necessary to fix the bug,
so we can easily backport it to -stable releases etc.

If you want to perform a variable name or other similar cosmetic
improvement, you can send a follow-up patch that does so.

Thank you.
