From: Meelis Roos <mroos@linux.ee>
Date: Sun, 21 Jan 2007 15:25:02 +0000
Subject: Re: Linux on Sun e10k
Message-Id: <20070121152502.C080F13F98@rhn.tartu-labor>
List-Id: <sparclinux.vger.kernel.org>
References: <1169241607.30406.19.camel@duo.jes.ee>
In-Reply-To: <1169241607.30406.19.camel@duo.jes.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

TS> Warning: unable to open an initial console.

Try to use network console if the native console is not supported.
netconsole=..., see Documentation/networking/netconsole.txt

-- 
Meelis Roos
