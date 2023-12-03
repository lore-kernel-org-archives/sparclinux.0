Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5CC28FE;
	Sun,  3 Dec 2023 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANc3f6u9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE71C433C8;
	Sun,  3 Dec 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701598468;
	bh=y6guoQ7JWLb6nFfFVlYe/P/b7whl0hnphrJFPbci+gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANc3f6u9EJ1ssuxlufhHFIfCJXuS+5oWXzSwIs67To6kWkn4rM1AnGhiZ8OET+DzD
	 BJ0ThA4/ZrHd8ZdZuOP7SgL+PaY62RFymEtlgn6DvuxLngtM/RcjMGvia/dCb5GAY2
	 xRIWJGXwJpWSBf9S1v38Ux5kfOPwOvoNc5tBznfjUbCEnViqTDZSXeVp0UBfvNiC6o
	 G2JoRJPw9ZkD8Cka9somYHgg4zMQmsyHtvMuIKNySqyOxNtB4HuegMnJnqD2pR1O40
	 DBUYwHtlTBHiDQ0ECMWhWsSHnZ26BNrN8+Vcj7yl3mqVlC5iN5fD91fWFJqnYorXBW
	 OID75cthdk4VA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 3/3] sparc: vdso: use $(addprefix ) instead of $(foreach )
Date: Sun,  3 Dec 2023 19:14:18 +0900
Message-Id: <20231203101418.1910661-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203101418.1910661-1-masahiroy@kernel.org>
References: <20231203101418.1910661-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

$(addprefix ) is slightly shorter and more intuitive.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 03a32b6156ee..7f5eedf1f5e0 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -13,7 +13,7 @@ obj-y				+= vma.o
 obj-$(CONFIG_SPARC64)		+= vdso-image-64.o
 obj-$(CONFIG_COMPAT)		+= vdso-image-32.o
 
-vobjs := $(foreach F,$(vobjs-y),$(obj)/$F)
+vobjs := $(addprefix $(obj)/, $(vobjs-y))
 
 $(obj)/vdso.o: $(obj)/vdso.so
 
-- 
2.40.1

