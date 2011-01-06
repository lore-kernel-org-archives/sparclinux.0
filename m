From: vincent@cojot.name
Date: Thu, 06 Jan 2011 15:43:20 +0000
Subject: Re: [PATCH v2] cassini: Use local-mac-address prom property for
Message-Id: <alpine.LRH.2.02.1101061618030.20587@thorbardin.lasthome.solace.krynn>
List-Id: <sparclinux.vger.kernel.org>
References: <1294321167.6193.69.camel@duncow>
In-Reply-To: <1294321167.6193.69.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Hi everyone,

Sorry for stepping in but aside from these patches, is there a current 
maintainer for the cassini driver who's willing to help debug a few 
issues?

I currently have a few X4422A cards which I'm trying to use on recent 
x86 hardware under Centos5 and the cards 'work' but their network 
performance spectrum is very strange:

iperf starts around 400Mb/s then 
starts dropping and dropping - currently around 40Mb/s after an hour of 
iperf, as measured from another centos5 system with e1000e on an idle 
network.

Looking at the source, there were also some ifdefs for which I couldn't 
find a log/reason for:
USE_HP_WORKAROUND, CAS_HP_ALT_FIRMWARE, etc...

Any ideas, etc...?

Vincent
