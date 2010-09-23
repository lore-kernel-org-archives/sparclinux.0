From: Meelis Roos <mroos@linux.ee>
Date: Thu, 23 Sep 2010 19:28:58 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <alpine.DEB.2.00.1009232227040.9048@ondatra.cyber.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
In-Reply-To: <19611.34846.813757.309183@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The 2.6.36-rc kernels do appear to be solid on a UP Ultra5, but that
> one no longer does any gcc builds or tests, only kernel builds.

I have gotten one hang on UP Ultra 5 about a week ago with then-current 
2.6.36-rc snapshot. It happened during or after git gc --aggressive. Could 
not reproduce it.

-- 
Meelis Roos (mroos@linux.ee)
