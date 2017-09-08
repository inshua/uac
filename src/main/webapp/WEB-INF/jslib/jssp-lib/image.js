//load("nashorn:mozilla_compat.js");
//importPackage(java.awt);
//importPackage(java.awt.image);
//importPackage(java.io);
//importPackage(javax.imageio);
//importPackage(java.text);
//
//importPackage(com.sun.image.codec.jpeg);

var importedJavaPackage = new JavaImporter(
		java.awt, java.awt.image, java.io, javax.imageio, java.text, com.sun.image.codec.jpeg  
    );

/**
 * 进行图片的压缩工作
 * 
 * @author Administrator
 * 
 */
function ImageUtils(){}

    /**
	 * @description 当scale为true时就是按比例所进行缩放,当scale为false时就按固定的宽和高来缩放
	 * @param byte[]
	 *            srcImage
	 * @param int
	 *            newWidth
	 * @param int
	 *            newHeight
	 * @param boolean
	 *            scale
	 */
ImageUtils.compressBytesByScale = function(srcImage,newWidth,newHeight,scale){
	with(importedJavaPackage){
		var bis = new ByteArrayInputStream(srcImage);
		var img = ImageIO.read(bis);
		var srcHeight = img.getHeight(null);
		var srcWidth = img.getWidth(null);
		// 判断是否是等比缩放
		if (scale == true) {
			// 为等比缩放计算输出的图片宽度及高度
			var rate1 = img.getWidth(null) / newWidth ;
			var rate2 = img.getHeight(null) / newHeight;
			// 根据缩放比率大的进行缩放控制
			var rate = rate1 > rate2 ? rate1 : rate2;
			newWidth = parseInt(img.getWidth(null) / rate);
			newHeight =parseInt(img.getHeight(null) / rate);
		}
		var newImage = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		/*
		 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
		 */
		newImage.getGraphics().drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		
		var bos = new ByteArrayOutputStream();
		var encoder = JPEGCodec.createJPEGEncoder(bos);
		// var param = encoder.getDefaultJPEGEncodeParam(newImage);
		// param.setQuality(quality, false);//设置图片的质量
		// encoder.encode(newImage,param);
		encoder.encode(newImage);
		
		bis.close();
		bos.close();
		return bos.toByteArray();
	}
}
	
	/**
	 * @param srcImage
	 * @param newWidth
	 * @param newHeight
	 * @param scale
	 * @param quality
	 * @return
	 * @throws IOException
	 */
ImageUtils.compressBytesByScaleAndQuality = function(srcImage,newWidth,newHeight,scale,quality){
	with(importedJavaPackage){
		var bis = new ByteArrayInputStream(srcImage);
		
		var img = ImageIO.read(bis);
		
		var srcHeight = img.getHeight(null);
		var srcWidth = img.getWidth(null);
		
		// 判断是否是等比缩放
		if (scale == true) {
			// 为等比缩放计算输出的图片宽度及高度
			var rate1 = img.getWidth(null)/ newWidth;
			var rate2 = img.getHeight(null)/ newHeight;
			// 根据缩放比率大的进行缩放控制
			var rate = rate1 > rate2 ? rate1 : rate2;
			newWidth = parseInt(img.getWidth(null) / rate);
			newHeight = parseInt(img.getHeight(null) / rate);
		}
		var newImage = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		/*
		 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
		 */
		newImage.getGraphics().drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		
		var bos = new ByteArrayOutputStream();
		var encoder = JPEGCodec.createJPEGEncoder(bos);
		var param = encoder.getDefaultJPEGEncodeParam(newImage);  
		param.setQuality(quality, false);// 设置图片的质量
		encoder.encode(newImage,param);
		// encoder.encode(newImage);
		
		bis.close();
		bos.close();
		return bos.toByteArray();
	}
}
	
ImageUtils.compressFileByScaleAndQuality = function(srcPath,outPath,newWidth,newHeight,scale,quality){
	with(importedJavaPackage){
		var img = ImageIO.read(new File(srcPath));
		
		var srcHeight = img.getHeight(null);
		var srcWidth = img.getWidth(null);
		
		// 判断是否是等比缩放
		if (scale == true) {
			// 为等比缩放计算输出的图片宽度及高度
			var rate1 = img.getWidth(null)/newWidth;
			var rate2 =  img.getHeight(null)/newHeight;
			// 根据缩放比率大的进行缩放控制
			var rate = rate1 > rate2 ? rate1 : rate2;
			newWidth = parseInt(img.getWidth(null) / rate);
			newHeight = parseInt(img.getHeight(null) / rate);
		}
		var newImage = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		/*
		 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
		 */
//		newImage.getGraphics().drawImage(
//				img.getScaledInstance(newWidth, newHeight,
//						Image.SCALE_SMOOTH), 0, 0, null);
		
		var fos = new FileOutputStream(outPath);
		var encoder = JPEGCodec.createJPEGEncoder(fos);
		var param = encoder.getDefaultJPEGEncodeParam(newImage);  
		param.setQuality(quality, false);// 设置图片的质量
		encoder.encode(newImage,param);
// encoder.encode(newImage);
		fos.close();
	}
}

ImageUtils.compressBytes = function(srcImage){
	with(importedJavaPackage){
		var bis = new ByteArrayInputStream(srcImage);
		
		var img = ImageIO.read(bis);
		
		var newWidth = img.getWidth(null);
		var newHeight = img.getHeight(null);
		
		// 判断是否是等比缩放
		
		var newImage = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		/*
		 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
		 */
		newImage.getGraphics().drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		
		var bos = new ByteArrayOutputStream();
		var encoder = JPEGCodec.createJPEGEncoder(bos);
		encoder.encode(newImage);
		
		bis.close();
		bos.close();
		return bos.toByteArray();
	}
}
	
	/**
	 * @param srcImage
	 * @param scale
	 * @param quality
	 * @return
	 * @throws IOException
	 */
ImageUtils.compressBytesByScaleAndQualityNoWH = function(srcImage,scale,quality){
	with(importedJavaPackage){
		var bis = new ByteArrayInputStream(srcImage);
		var img = ImageIO.read(bis);
		
		var srcWidth = img.getWidth(null);
		var srcHeight = img.getHeight(null);
		
		var newWidth = parseInt(srcWidth*scale);
		var newHeight = parseInt(srcHeight*scale);
		
		var newImage = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		newImage.getGraphics().drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		var bos = new ByteArrayOutputStream();
		var encoder = JPEGCodec.createJPEGEncoder(bos);
		
		var param = encoder.getDefaultJPEGEncodeParam(newImage);  
        param.setQuality(quality, false);// 设置图片的质量
		encoder.encode(newImage,param);
		bis.close();
		bos.close();
		return bos.toByteArray();
	}
}

	/**
	 * @param srcPath
	 * @param outPath
	 * @param scale
	 * @param quality
	 * @throws IOException
	 */
ImageUtils.compressFileByScaleAndQualityNoWH = function( srcPath, outPath, scale, quality) {
	with(importedJavaPackage){
		var img = ImageIO.read(new File(srcPath));
		var srcWidth = img.getWidth(null);
		var srcHeight = img.getHeight(null);
		var newWidth = parseInt(srcWidth*scale);
		var newHeight = parseInt(srcHeight*scale);
		var newImage = new BufferedImage( newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
		newImage.getGraphics().drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		var fos = new FileOutputStream(outPath);
		var encoder = JPEGCodec.createJPEGEncoder(fos);
		var param = encoder.getDefaultJPEGEncodeParam(newImage);  
        param.setQuality(quality, false);// 设置图片的质量
		encoder.encode(newImage,param);
		fos.close();
	}
}
	
	/**
	 * @param srcPath
	 * @param outPath
	 * @param scale
	 * @param quality
	 * @throws IOException
	 */
ImageUtils.compress = function( srcPath, outPath,
			 content,
			 x, y,
			 fontName, fontStyle, fontSize,
			 color,
			 alpha,
			 scale, quality) {
	with(importedJavaPackage){
		var img = ImageIO.read(new File(srcPath));
		var srcWidth = img.getWidth(null);
		var srcHeight = img.getHeight(null);
		var newWidth = parseInt(srcWidth*scale);
		var newHeight = parseInt(srcHeight*scale);
		var newImage = new BufferedImage( newWidth, newHeight, BufferedImage.TYPE_INT_RGB);
		var g = newImage.createGraphics();
		g.drawImage(
				img.getScaledInstance(newWidth, newHeight,
						Image.SCALE_SMOOTH), 0, 0, null);
		
		g.setFont(new Font(fontName, fontStyle, fontSize));
		g.setColor(color);
		g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, alpha));
		g.drawString(content, x, y);
		g.dispose();
		
		var fos = new FileOutputStream(outPath);
		var encoder = JPEGCodec.createJPEGEncoder(fos);
		var param = encoder.getDefaultJPEGEncodeParam(newImage);  
        param.setQuality(quality, false);// 设置图片的质量
		encoder.encode(newImage,param);
		fos.close();
	}
}

ImageUtils.getFileSize=function(fileS) {// 转换文件大小
	with(importedJavaPackage){
		var df = new DecimalFormat("#.00");
		var fileSizeString = "";
		if (fileS < 1024) {
			fileSizeString = df.format(fileS) + "B";
		} else if (fileS < 1048576) {
			fileSizeString = df.format(fileS / 1024) + "KB";
		} else if (fileS < 1073741824) {
			fileSizeString = df.format(fileS / 1048576) + "M";
		} else {
			fileSizeString = df.format(fileS / 1073741824) + "G";
		}
		return fileSizeString;
	}
}

function test(){
	ImageUtils.compressFileByScaleAndQuality("e:\\test\\test.jpg", "e:\\test\\test_myscale_js.jpg",850,1170,true,0.5);
}

var img_compress_type='wh';

var img_compress_scale = 0.5;
var img_compress_quality = 0.7;

var img_compress_width=850;
var img_compress_height=1170;
var img_compress_isscale = true;