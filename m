From: David Miller <davem@davemloft.net>
Date: Mon, 02 Mar 2015 05:35:22 +0000
Subject: Re: [PATCH] arch: sparc: kernel: starfire.c: Remove unused function
Message-Id: <20150302.003522.604641713348702778.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1419079367-32084-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1419079367-32084-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rickard_strandqvist@spectrumdigital.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 20 Dec 2014 13:42:47 +0100

> Remove the function starfire_hard_smp_processor_id() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Applied.
