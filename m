From: "Konrad Eisele" <eiselekd@web.de>
Date: Tue, 12 Apr 2005 12:50:54 +0000
Subject: SMP on virtually indexed/tagged cache
Message-Id: <737167738@web.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I trying to get sparc32-smp run on a Leon3 sparc,
it uses a  virtually indexed/tagged cache. Is it possible
to run smp on such a processor? Can cache coherence 
be maintained my the linux kernel only and is there a 
architecture that does that? 
Maybe I have to add a vhdl hardware mechanism to Leon3,
but it would be easier if it could be done in software.
-- Thanks Konrad 

