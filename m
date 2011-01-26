From: daniel@gaisler.com
Date: Wed, 26 Jan 2011 20:37:22 +0000
Subject: Re: [PATCH v3] SPARC: added U-Boot build target: uImage
Message-Id: <20110126153722.n1w5ybi4rsosss0k@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1296059795-22807-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1296059795-22807-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



On Wed, 26 Jan 2011 21:10:37  0100, Sam Ravnborg  wrote:
On Wed, Jan 26, 2011 at 05:36:35PM  0100, Daniel Hellstrom wrote:
  > > This is only for LEON as u-boot for SPARC only supports LEON. 
  > >
  > > Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
  >
  > Looks good. 
  > Acked-by: Sam Ravnborg <sam@ravnborg.org>
  >
  > A general note about patch subjects. 
  >
  > I have started to use the following conventions for
  > patch subjects:
  >
  > sparc: bla         <= stuff that is relevant for sparc32 and sparc64
  > sparc32: bla       <= sparc32 specific stuff
  > sparc64: bla       <= sparc64 specific stuff
  > sparc32,leon: bla  <= leon specific stuff (on sparc32)
  > sparc32,sun4m: bla <= sun4m specific stuff (on sparc32)
  >
  > I try to find something useful as "bla" - this is sometimes defficult.. 
  >
  > If I could convince you to use same syntax we could get
  > a bit more consistency in the patch subjects. 
   
   
  Sounds reasonable, will adopt to that.. hopefully others will do too... :)
   
   

