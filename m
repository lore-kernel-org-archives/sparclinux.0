From: "Daniel 'NebuchadnezzaR' Dehennin" <sparc@asgardr.info>
Date: Wed, 05 Apr 2006 20:46:45 +0000
Subject: clone return code
Message-Id: <87psjvu4wa.fsf@thorr.asgardr.info>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Hello,

Sorry if that question seems idiot but is it normal that clone return
the parent pid in the child ?

Is seems that on other architectures it have the same behavior than
fork: return 0 in the child.

Regards.
-- 
Daniel 'NebuchadnezzaR' Dehennin
Récupérer ma clef GPG:
gpg --keyserver pgp.mit.edu --recv-keys 0x2A408F69
